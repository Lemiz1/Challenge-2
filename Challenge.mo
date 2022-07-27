import Text "mo:base/Text";
import Nat8 "mo:base/Nat8";
import Debug "mo:base/Debug";
import Char "mo:base/Char";
import Array "mo:base/Array";
actor{
    //challenge 1
    public func nat_to_nat8 (n : Nat) : async Nat8{
        if (n > 255) {
            Debug.trap("Oops!");
        }
        else{
            return(Nat8.fromNat(n));
        };
        
    };

    //Challenge 2
    public func max_number_with_n_bits(n : var Nat) : async Nat{
        var count : Nat = n;
        var max : Nat = 0;
        while (count > 0) {
            max  := max + 2**(n-1);
            count -= 1;
        }
        return (count);
    };

    //Challenge 3
    public func decimal_to_bits (n : Nat) : async Text{
        var number = n;
        var result : Text = "";
        while (number > 0) {
            if (number % 2 == 0) {
                result #= "0";
            }
            else{
                result #= "1";
            };
            number := number /2;
        };
        // Haven't reverse the binary
        return (result);
    };

    // Challenge 4 + 5: The ideas is the same
    public func capitalize_char(c : Char) : async Char{
        message : Text = Char.toText(c);
        return(Text.map(message, Prim.charToUpper));
    };

    // Or with ASCII Approach - method applie only for challenge 4
    public func capitalize_char_ASCII(c: Char) : async Char{
        return(Char.fromNat32(Char.toNat32(c) + 20));
    };

    //Challenge 6
    public func is_inside(t : Text, c: Char) : async Bool{
        let pattern = #text(Char.toText(c));
        return(Text.contains(t, pattern));
    };

    //Challenge 7
    public func trim_whitespace(t : Text) : async Text{
        let whiteSpace = #text(" ");
        return(Text.trimStart(t, whiteSpace));
    };

    //Challenge 8
    
    public func duplicated_character(t : Text) : async Text{
        for (character in t.chars()){
            if(Text.contains(t, #text(Char.toText(character)))){
                return(Text.fromChar(character));
            };
        };
        return(t);

    };
  

 

    //Challenge 9
    public func size_in_bytes(t : Text) : async Nat{
        var encoded_UTF8 = Text.encodeUtf8(t);
        return(Array.size(Blob.toArray(encoded_UTF8)));
    };


    //Challenge 10
    private func swap(array: [Nat], a : Nat, b : Nat) : [Nat] {
        var mutable = Array.thaw<Nat>(array);
        var temp = mutable[a];
        mutable[a] := mutable[b];
        mutable[b] := temp;

        return(Array.freeze<Nat>(mutable));


    };


    public func bubble_sort(num_array : [Nat]) : async [Nat] {
        
        var sorted = num_array;
        var i = 1;
        var size = num_array.size();
        var j = 0;
        while (i < size) {
            while (j < size - i -1 ) {
                if (sorted [j + 1] < sorted[j]) {
                    //Swap
                    sorted := swap(sorted, j, j + 1);
                };

                j += 1;
            };
            i += 1;
        };

        return(sorted);
    };

    //Challenge 11 
    public func nat_opt_to_nat(n : ?Nat, m:Nat) : async Nat{
        switch(n){
            case(null) {
                return(m);
            };
            case(?n) {
                return(n);
            };
        };
    };


    //Challenge 12
    public func day_of_the_week(n : Nat) : async ?Text{
        switch(n) {
            case(1){
                return(?"Monday");
            };

            //You can use more case but I'm too lazy so ...
            case(_){
                return(null);
            };
        };
    };


    // Challenge 13
    let f = func(x : ?Nat) : ?Nat {
        switch(x){
            case(null) return(?0);
            case(?x) return(?x);
        };
    };


    public func populate_array(popArray : [?Nat]) : async [Nat] {
        return(Array.mapFilter<?Nat, Nat>(popArray, f));
    };


    //Challenge 14

    var storeStum : Nat = 0;
    let fun = func(y : Nat) : ?Nat{
        storeStum += y;
        return(storeStum);
    };

    public func sum_of_array(sumArray : [Nat]) : async Nat{
        var newArray = sumArray;
        Array.mapFilter<Nat, Nat>(newArray, fun);
        return(storeStum);
    };


    let squareFun (x : Nat) : Nat{
        return(x*x);
    };
    //Challenge 15
    public func squared_array(squareArray : [Nat]) : async [Nat]{
        var squareAns = squareArray;
        return(Array.map<Nat, Nat>(squareAns, squareFun));
    };

    
    //Challenge 16
    let increase = func(x : Nat, y : Nat) : Nat{
        return(x+y);
    };
  
    public func increase_by_index(i_array :[Nat]) :async  [Nat]{
        var indexArray = i_array;
        return(Array.mapEntries<Nat, Nat>(indexArray, increase));
    };

    //Challenge 17 - store this in a module and import Nat base
    
    public func contains<A>(array : [Nat], a : Nat) : async Bool {
        var containsArray = array;
        let storeCon = Array.find<Nat>(containsArray, func x{
            return(x == a);
        });

        switch(storeCon){
          case(null){
            return(false);
          };
          case(?storeCon){
            return(true);
          }
        }
    };













}