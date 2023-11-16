fx_version 'cerulean'
game 'gta5'

description 'QBX_Interior'
repository 'https://github.com/Qbox-project/qbx_interior'
version '1.1.0'

this_is_a_map 'yes'

shared_scripts {
	'@ox_lib/init.lua',
	'@qbx_core/modules/utils.lua'
}

client_scripts {
	'client/main.lua',
	'client/optional.lua'
}

server_scripts {
	'server/main.lua',
	'server/optional.lua'
}

files {
	'stream/starter_shells_k4mb1.ytyp'
}

-- Default (included)
data_file 'DLC_ITYP_REQUEST' 'starter_shells_k4mb1.ytyp'

lua54 'yes'
use_experimental_fxv2_oal 'yes'