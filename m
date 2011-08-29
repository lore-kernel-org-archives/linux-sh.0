From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 29 Aug 2011 06:46:14 +0000
Subject: Re: [PATCH] sh: Fix implicit declaration of function numa_node_id
Message-Id: <20110829064614.GC31809@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1314335141-15887-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
In-Reply-To: <1314335141-15887-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Aug 26, 2011 at 02:05:41PM +0900, Nobuhiro Iwamatsu wrote:
>   CC      arch/sh/kernel/topology.o
>   arch/sh/kernel/topology.c: In function ???topology_init???:
>   arch/sh/kernel/topology.c:77: error: implicit declaration of function ???numa_node_id???
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>

Against what tree? I don't have anything this applies to.
