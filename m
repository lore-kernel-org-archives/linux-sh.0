From: syzbot <syzbot+9c1be56e9317b795e874@syzkaller.appspotmail.com>
Date: Fri, 14 Aug 2020 02:53:05 +0000
Subject: Re: BUG: unable to handle kernel paging request in fl_dump_key
Message-Id: <0000000000001e967a05accd8573@google.com>
List-Id: <linux-sh.vger.kernel.org>
In-Reply-To: <000000000000735f5205a5b02279@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: benh@kernel.crashing.org, dalias@libc.org, davem@davemloft.net, jhogan@kernel.org, jhs@mojatatu.com, jiri@mellanox.com, jiri@resnulli.us, kuba@kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-mips@vger.kernel.org, linux-sh@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, netdev@vger.kernel.org, paul.burton@mips.com, paulus@samba.org, ralf@linux-mips.org, shuah@kernel.org, syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com, ysato@users.sourceforge.jp

syzbot has bisected this issue to:

commit a51486266c3ba8e035a47fa96df67f274fe0c7d0
Author: Jiri Pirko <jiri@mellanox.com>
Date:   Sat Jun 15 09:03:49 2019 +0000

    net: sched: remove NET_CLS_IND config option

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17463509900000
start commit:   1ca0fafd tcp: md5: allow changing MD5 keys in all socket s..
git tree:       net
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14c63509900000
console output: https://syzkaller.appspot.com/x/log.txt?x=10c63509900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=BF3aec367b9ab569
dashboard link: https://syzkaller.appspot.com/bug?extid=9C1be56e9317b795e874
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1062a40b100000

Reported-by: syzbot+9c1be56e9317b795e874@syzkaller.appspotmail.com
Fixes: a51486266c3b ("net: sched: remove NET_CLS_IND config option")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
