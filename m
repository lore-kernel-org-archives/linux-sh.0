From: Rob Landley <rob@landley.net>
Date: Fri, 24 Apr 2020 19:20:07 +0000
Subject: Re: [PATCH 1/2] sh: remove sh5 support
Message-Id: <f25e9217-f1b7-ca8f-7a80-9dfb2d340908@landley.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20200420123844.3998746-1-arnd@arndb.de>
In-Reply-To: <20200420123844.3998746-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 4/20/20 7:38 AM, Arnd Bergmann wrote:
> sh5 never became a product and has probably never really worked.
> 
> Remove it by recursively deleting all associated Kconfig options
> and all corresponding files.
> 
> For review purposes, this leaves out the files that can now be
> removed, in particular
> 
>  arch/sh/drivers/pci/*-sh5.c
>  arch/sh/include/asm/*_64.h
>  arch/sh/include/uapi/asm/*_64.h
>  arch/sh/include/cpu-sh5/*
>  arch/sh/kernel/cpu/sh5/*
>  arch/sh/lib64/*
>  arch/sh/mm/*-sh5.c
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked in principle, I'll try to test that it doesn't break any of my configs
this weekend.

(There are plans for 64 bit j-core that have nothing to do with SH5, and we can
submit brand new infrastructure for j64 when we get there.)

Rob
