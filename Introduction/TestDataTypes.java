public class TestDataTypes
{
    public static void main( String[] args )
    {
        // byte, 1 byte, -128 to 127
        byte a = 3;
        System.out.println( a );
    
        // short, 2 bytes, -32768 to 32767
        short b = 3;
        System.out.println( b );
        
        // int, 4 bytes, -2147483648 to 2147483647
        int c = 387;
        System.out.println( c );
        
        // long, 8 bytes, -9223372036854775808 to 9223372036854775807
        long d = 387L;
        System.out.println( d );
        
        // float, 4 bytes
        float e = 3.1F;
        System.out.println( e );
        
        // double, 8 bytes
        double f = 3.1;
        System.out.println( f );
        
        // boolean
        boolean g = true;
        System.out.println( g );

        // char
        char h = 'c';
        System.out.println( h );
        
        // constant
        final int MY_CONSTANT = 42;
        System.out.println( MY_CONSTANT );
    }
}