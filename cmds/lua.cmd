require lua,2.0.0


epicsEnvSet("TOP", "$(E3_CMD_TOP)/..")
epicsEnvSet("LUA_SCRIPT_PATH", "$(TOP)/lua/iocBoot/iocLuaShell/scripts")


#for i = 1, 3 do
dbLoadRecords("$(TOP)/lua/luaApp/Db/luascripts10.db", "P=lua:,R=set1:")
dbLoadRecords("$(TOP)/lua/luaApp/Db/luascripts10.db", "P=lua:,R=set2:")
dbLoadRecords("$(TOP)/lua/luaApp/Db/luascripts10.db", "P=lua:,R=set3:")
#end

#---------------
iocInit()
#---------------


#-- Runs a script in the background
luaSpawn("tick.lua")

dbl()

