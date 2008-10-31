From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 31 Oct 2008 07:23:29 +0000
Subject: Re: [PATCH] NFS boot panic fix on Migo-r
Message-Id: <20081031072329.GG26928@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <ur65x8c89.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <ur65x8c89.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Oct 31, 2008 at 04:01:19PM +0900, Kuninori Morimoto wrote:
> 
> NFS boot is very important for developer,
> but kernel panic occur when I use migor_defconfig.
> Because there is no setting for it.
> This patch fix this problem.
> 
> Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>

Your subject is a bit alarmist. What this does is enable NFS root by
default in the defconfig. I've applied it with a slightly less frantic
subject :-)
