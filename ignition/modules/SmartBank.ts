import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const MicjohnModule = buildModule("MicjohnModule", (m) => {

    const smartBank = m.contract("SmartBank");

    return { smartBank };
});

export default MicjohnModule;