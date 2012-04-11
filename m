From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 11 Apr 2012 03:48:06 +0000
Subject: Re: [PATCH 3/4] sh: Add RSK2+SH7264 board
Message-Id: <20120411034806.GA19696@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1334062853-23045-4-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1334062853-23045-4-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Apr 10, 2012 at 02:00:52PM +0100, Phil Edworthy wrote:
> The RSK2+SH7264 board uses the sh7264 processor. It is often
> referred to as just rsk7264. NOR Flash, SDRAM, serial, USB Host and
> ethernet are working.
> 
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>

On Tue, Apr 10, 2012 at 02:00:53PM +0100, Phil Edworthy wrote:
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> ---
>  arch/sh/boards/mach-rsk/Kconfig         |    1 +
>  arch/sh/include/cpu-sh2a/cpu/sh7264.h   |  176 +++
>  arch/sh/kernel/cpu/sh2a/Makefile        |    1 +
>  arch/sh/kernel/cpu/sh2a/pinmux-sh7264.c | 2136 +++++++++++++++++++++++++++++++
>  4 files changed, 2314 insertions(+), 0 deletions(-)
>  create mode 100644 arch/sh/include/cpu-sh2a/cpu/sh7264.h
>  create mode 100644 arch/sh/kernel/cpu/sh2a/pinmux-sh7264.c
> 
Both of these look fine as they are.
