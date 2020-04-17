
local function catch_cmd_output(prog)
    local fh = io.popen(prog, 'r')
    if nil~=fh then
        local ss = fh:read('*a')
        fh:close()

        return ss
    end
end

local function gen_an_randstr()
    local out = catch_cmd_output('cat  /dev/urandom | od -X |head -n1')
    local s = string.match(out, '^%S+%s+(%S+)')
    return s
end

local surfixVM = '.kalend'
local batch_file = 'todo.txt'

for line in io.lines(batch_file) do
    local member_name = string.gsub(line, '%.', '')
    local passwd = gen_an_randstr()
    print(member_name, passwd)

    local docker_cmd = string.format('docker run --name %s --hostname=%s --net=mynet -p 22 -v /data/%s:/data -e PASSWD=beatcovid19 -e USER2=%s -e PASSWD2=%s  --memory=128m -d ka_sshd',
    member_name, member_name, member_name, member_name, passwd)

    os.execute(docker_cmd)

    local get_IP_cmd = string.format('docker exec %s tail -n1 /etc/hosts', member_name)
    local r1 = catch_cmd_output(get_IP_cmd)
    local the_IP = string.match(r1, '^(%S+)%s')

    local one = string.format('|%s|%s|%s|%s|',member_name, passwd, member_name.. surfixVM, the_IP)
    print(one)
    local two = string.format('address=/%s/%s', member_name.. surfixVM, the_IP)

    os.execute(string.format('echo "%s" >> list1.txt', one))
    os.execute(string.format('echo "%s" >> name2ip.txt', two))
end