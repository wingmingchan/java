public class TestFactorial
{
    public static void main( String[] args )
    {
        // make sure that there is input
        if( args.length < 1 )
        {
            System.out.println( "An integer is needed to run this program" );
            return;
        }
        
        // try turning the input into an integer
        try
        {
            int input = Integer.parseInt( args[ 0 ] );
            System.out.println( factorial( input ) );
        }
        // something goes wrong
        catch( NumberFormatException e )
        {
            System.out.println( e + " The input argument is not an integer." );
        }
    }
    
    /*
        Returns the factorial of num: num * (num - 1) * (num - 2) * ... * 1
    */
    public static int factorial( int num )
    {
        if( num < 1 )
        {
            System.out.println( "The number cannot be smaller than 1" );
            return 0;
        }
        else if( num == 1 )
        {
            return num;
        }
        else if( num > 10 )
        {
            System.out.println( "The number is too big and I cannot handle it." );
            return 0;
        }
        else
        {
            return num * factorial( num - 1 );
        }
    }
}