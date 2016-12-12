import Test.Cabal.Prelude
-- TODO: Enable this test on Windows
main = setupAndCabalTest $ do
    skipIf =<< isWindows
    withSymlink "bin/ghc-7.10" "ghc" $ do
        env <- getTestEnv
        let cwd = testCurrentDir env
        ghc_path <- programPathM ghcProgram
        r <- withEnv [("WITH_GHC", Just ghc_path)]
           . fails $ setup' "configure" ["-w", cwd </> "ghc"]
        assertOutputContains "is version 9999999" r