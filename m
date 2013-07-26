From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 26 Jul 2013 23:55:12 +0000
Subject: Re: [PATCH] ARM: shmobile: BOCK-W: fix SDHI0 PFC settings
Message-Id: <51F30C60.5050504@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201307270346.34002.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201307270346.34002.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

On 07/27/2013 03:46 AM, Sergei Shtylyov wrote:

> The following message is printed on the BOCK-W kernel bootup:

> sh-pfc pfc-r8a7778: invalid group "sdhi0" for function "sdhi0"

> In addition, SD card cannot be detected.  The reason is apparently that commit
> ca7bb309485e4ec89a9addd47bea (ARM: shmobile: bockw: add SDHI0 support) matched
> the previous version of commit 564617d2f92473031d035deb273da5 (sh-pfc: r8a7778:
> add SDHI support).

> Add the missing pin groups according to the BOCK-W board schematics.

> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

> ---
> The patch is atop of Simon's 'renesas.git' repo, 'renesas-devel-20130726' tag.

    It also applies to the current Linus' tree cleanly. Please push it for 3.11.

WBR, Sergei

