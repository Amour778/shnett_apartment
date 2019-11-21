public class OptionalTrailingArguments {
    public static void main(String[] args) {

        test();
        test("aaa");
        test("aaa", "bbb");
        test("aaa", "bbb", "ccc");
    }

    public static void test(String... args) {
        System.out.println(args.getClass());
        for (String arg : args) {
            System.out.println(arg);
        }
    }
}
