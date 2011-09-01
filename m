From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Thu, 01 Sep 2011 21:05:31 +0000
Subject: Re: [PATCH] sh: Fix implicit declaration of function numa_node_id
Message-Id: <CABMQnV+1MCnuDpZBU2jbHCZy1=fjZRi-Eq_25-2MSvr2+vP=9A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1314335141-15887-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
In-Reply-To: <1314335141-15887-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

2011/8/29 Paul Mundt <lethal@linux-sh.org>:
> On Fri, Aug 26, 2011 at 02:05:41PM +0900, Nobuhiro Iwamatsu wrote:
>> =A0 CC =A0 =A0 =A0arch/sh/kernel/topology.o
>> =A0 arch/sh/kernel/topology.c: In function ???topology_init???:
>> =A0 arch/sh/kernel/topology.c:77: error: implicit declaration of functio=
n ???numa_node_id???
>>
>> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
>
> Against what tree? I don't have anything this applies to.

From linux-next.  This problem is caused by the commit
d497d16880f15b3798c6e9c078ce7f9d70bbd6bc.
However, this patch is not yet applied in Linus-tree. Please apply in
my patch if applied.
