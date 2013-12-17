From: WANG Chao <chaowang@redhat.com>
Date: Tue, 17 Dec 2013 05:37:30 +0000
Subject: Re: [PATCH 0/4] Minor fixes and improvements for kexec
Message-Id: <20131217053730.GA13848@dhcp-17-89.nay.redhat.com>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1386807069.git.geoff@infradead.org>
In-Reply-To: <cover.1386807069.git.geoff@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geoff Levand <geoff@infradead.org>
Cc: linux-sh@vger.kernel.org, kexec@lists.infradead.org, Paul Mundt <lethal@linux-sh.org>, Paul Mackerras <paulus@samba.org>, Eric Biederman <ebiederm@xmission.com>, linuxppc-dev@lists.ozlabs.org

On 12/12/13 at 12:18am, Geoff Levand wrote:
> Hi Eric,
> 
> Here are a few minor fixes and improvements for kexec.  Please consider.
> 
> -Geoff
> 
> The following changes since commit 374b105797c3d4f29c685f3be535c35f5689b30e:
> 
>   Linux 3.13-rc3 (2013-12-06 09:34:04 -0800)
> 
> are available in the git repository at:
> 
>   git://git.linaro.org/people/geoff.levand/linux-kexec.git for-kexec
> 
> for you to fetch changes up to 594a3d26aac66e9668edc81d7bfb4e801575514f:
> 
>   sh/kexec: Fix kexec build warning (2013-12-11 16:03:27 -0800)
> 
> ----------------------------------------------------------------
> Geoff Levand (4):
>       kexec: Simplify conditional
>       kexec: Add IND_FLAGS macro
>       powerpc/kexec: Use global IND_FLAGS macro
>       sh/kexec: Fix kexec build warning

For this series (besides 4/4 v2):

Acked-by: WANG Chao <chaowang@redhat.com>

> 
>  arch/powerpc/kernel/machine_kexec_64.c |  2 --
>  arch/sh/kernel/machine_kexec.c         |  2 +-
>  include/linux/kexec.h                  |  1 +
>  kernel/kexec.c                         | 17 ++++++++++-------
>  4 files changed, 12 insertions(+), 10 deletions(-)
> 
> -- 
> 1.8.1.2
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
