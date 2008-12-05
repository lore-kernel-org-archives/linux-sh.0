From: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Date: Fri, 05 Dec 2008 07:14:29 +0000
Subject: Re: [PATCH] Add plain udivsi3 (not _i4*) for gcc-4.1 and lower.
Message-Id: <4938D4D5.7040900@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <49389A5D.5040107@renesas.com>
In-Reply-To: <49389A5D.5040107@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Takashi Yoshii wrote:
> As shown in arch/sh/lib/udivsi3.S (and -Os.S),
> 
>   .global __udivsi3_i4i
>   .global __udivsi3_i4
>   .global __udivsi3
> __udivsi3_i4i:
>   ...
> 
> Three symbols are sharing one code, which is actually udivsi3_i4i.
> But, this results unwanted code with gcc 4.1.
> 
> In gcc, these three are treated as pseudo instructions that have own
>  clobber list apart from usual calling convention.
> According to sh's machine description. The clobber list is like below.
>  - udivsi3_i4i : t,r1,pr,mach,macl
>  - udivsi3_i4  : t,r0,r1,r4,r5,pr,dr0,dr2,dr4
>  - udivsi3     : t,r4,pr
> I don't think udivsi3_i4 is used in kernel, though.
> Caller of udivsi3 will be trouble with broken r1 and mac*.
> 
> gcc-4.1.x and older(at least to 3.4) generate udivsi3.
> # ST's gcc-4.1.1 seems to be OK because it has _i4i.
> 
> I checked git:lethal/master for ap325rxa.
>  the one compiled by gcc 4.1.2 was NG (No output to console),
>  while gcc 4.2.4 was OK
> I have added plain udivsi3 as a patch below.
> After that, both gcc 4.1.2 and 4.2.4 are OK
> 
> The patch is big because I renamed udivsi3*.S to udivsi3_i4i*.S.
> Another idea is giving new name to old udivsi3, like
>  udivsi3_gcc41x_and_lower.S
> 
> Any comment?
> /yoshii
> 
>  We chan't share code for udivsi3 and udivsi3_i4, because they have
>  different clobber list. Copied udivsi3 from gcc-4.1.2.
> 
> Signed-off-by: Takashi YOSHII <yoshii.takashi@renesas.com>
> ---
>  arch/sh/lib/Makefile         |    7 +-
>  arch/sh/lib/udivsi3-Os.S     |  151 ----------
>  arch/sh/lib/udivsi3.S        |  667 +++---------------------------------------
>  arch/sh/lib/udivsi3_i4i-Os.S |  149 ++++++++++
>  arch/sh/lib/udivsi3_i4i.S    |  666 +++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 862 insertions(+), 778 deletions(-)
>  delete mode 100644 arch/sh/lib/udivsi3-Os.S
>  create mode 100644 arch/sh/lib/udivsi3_i4i-Os.S
>  create mode 100644 arch/sh/lib/udivsi3_i4i.S
> 
Please use -C option.

Best regards,
 Nobuhiro
