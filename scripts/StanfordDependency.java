import edu.stanford.nlp.ling.CoreLabel;
import edu.stanford.nlp.ling.Sentence;
import edu.stanford.nlp.parser.lexparser.LexicalizedParser;
import edu.stanford.nlp.trees.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import py4j.GatewayServer;

/**
 * Created with IntelliJ IDEA.
 * User: Ji JianHui
 * Time: 2014-05-13 18:57
 * Email: jhji@ir.hit.edu.cn
 */
public class StanfordDependency
{
    private LexicalizedParser stanfordParser;
    private GrammaticalStructureFactory gsf;

    public StanfordDependency()
    {
        stanfordParser = LexicalizedParser.loadModel("edu/stanford/nlp/models/lexparser/englishPCFG.ser.gz");
        stanfordParser.setOptionFlags("-maxLength", "80", "-retainTmpSubcategories");

        TreebankLanguagePack tlp = new PennTreebankLanguagePack();
        gsf = tlp.grammaticalStructureFactory();
    }

    public String getDependency(String sentence)
    {
        List<CoreLabel> rawWords  = Sentence.toCoreLabelList( sentence.split(" ") );

        Tree parse = stanfordParser.apply(rawWords);

        GrammaticalStructure  gs  = gsf.newGrammaticalStructure(parse);
        List<TypedDependency> tdl = gs.typedDependenciesCCprocessed();

        ArrayList<Integer> subIndexs = new ArrayList<Integer>();
        ArrayList<Integer> objIndexs = new ArrayList<Integer>();

        System.out.println( "\n" + sentence);

        for( TypedDependency curDep : tdl )
        {
            String relation = curDep.reln().getShortName();

            if( relation.equalsIgnoreCase("nsubj") || relation.equalsIgnoreCase("nsubjpass") )
            {//名词主语
                int subIndex = curDep.dep().index() - 1;
                String sub   = curDep.dep().getLeaves().get(0).nodeString();
                System.out.print(" Subject: " + sub + " Index: " + subIndex);

                subIndexs.add(subIndex);
            }
            else if( relation.equalsIgnoreCase("dobj") || relation.equalsIgnoreCase("pobj") )
            {//直接宾语
                int objIndex = curDep.dep().index() - 1;
                String obj   = curDep.dep().getLeaves().get(0).nodeString();
                System.out.print(" Object: " + obj + " Index: " + objIndex);

                objIndexs.add(objIndex);
            }
        }
        System.out.println(" ");

        //String result = subIndex + ":" + sub + ";" + objIndex + ":" + obj;
        String result = "";
        String subResult = "", objResult = "";

        for( Integer subIndex:subIndexs ) subResult = subResult + ":" + subIndex;
        for( Integer objIndex:objIndexs ) objResult = objResult + ":" + objIndex;

        if( subResult.length() > 1 ) subResult = subResult.substring(1);
        if( objResult.length() > 1 ) objResult = objResult.substring(1);

        if( subResult.length() == 0 ) subResult = "-1";
        if( objResult.length() == 0 ) objResult = "-1";

        result = subResult + ";" + objResult;
        System.out.println(result);

        return result;
    }

    public static void main(String[] args) throws IOException
    {
        StanfordDependency dependency = new StanfordDependency();

        dependency.getDependency("Kenneth M. Evans , president of Thompson & Formby brand , was named group vice president of the do - it - yourself operating group .");

        GatewayServer server = new GatewayServer( dependency );
        server.start();
        System.out.println("Starting Server OK");
    }
}
