import 'dappsys/factory/factory.sol';

contract TheTAOFactory is DSAuthModesEnum {
    DSFactory _factory;

    function TheTAOFactory(DSFactory factory) {
        _factory = factory;
    }

    function createBasicInstance(uint n, uint m, uint exp)
             returns (address, address, address)
    {
        DSBasicAuthority authority = _factory.buildDSBasicAuthority();
        DSTokenFrontend token = _factory.installDSTokenBasicSystem(authority);
        DSEasyMultisig multisig = _factory.buildDSEasyMultisig(n, m, exp);
        token.updateAuthority(authority, DSAuthModes.Authority);
        authority.updateAuthority(multisig, DSAuthModes.Owner);

        return (authority, token, multisig);
    }

    function createOwnedInstance(uint n, uint m, uint exp)
             returns (address, address)
    {
        DSBasicAuthority authority = _factory.buildDSBasicAuthority();
        DSTokenFrontend token = _factory.installDSTokenBasicSystem(authority);
        token.updateAuthority(authority, DSAuthModes.Authority);

        return (authority, token);
    }

    function setupMultisig(DSBasicAuthority authority, uint n, uint m, uint exp)
             returns (address)
    {
        DSEasyMultisig multisig = _factory.buildDSEasyMultisig(n, m, exp);
        authority.updateAuthority(multisig, DSAuthModes.Owner);

        return multisig;
    }
}
