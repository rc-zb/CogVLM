{
  description = "CogVLM";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils }: flake-utils.lib.eachDefaultSystem (system: {
    devShells = let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixpkgs = pkgs.mkShell {
        name = "cogvlm";
        packages = with pkgs; [
          (python3.withPackages (ps: with ps; [
            # SwissArmyTransformer # Not included in Nixpkgs yet.
            transformers
            xformers
            torch
            torchvision
            # spacy # Not compatible with others.
            pillow
            # deepspeed # Not included in Nixpkgs yet.
            seaborn
            loguru
            streamlit
            timm
            accelerate
            pydantic
            openai
            sse-starlette
            fastapi
            httpx
            uvicorn
            jsonlines
          ]))
        ];
      };
      default = self.outputs.devShells.${system}.nixpkgs;
    };
  });
}
