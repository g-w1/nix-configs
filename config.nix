{
  allowUnfree = true;
   permittedInsecurePackages = [
     "libsixel-1.8.6"
   ];
     packageOverrides = super: let self = super.pkgs; in with self; rec {
             # inside here we can override or add new packages
             libc3 = import ~/dev/c3lib { inherit stdenv; };
       };
}
