From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 05 Jun 2013 08:29:01 +0000
Subject: Re: [PATCH 01/15] ARM: shmobile: Per-board uImage load addresses
Message-Id: <9933530.s16G7h846I@wuerfel>
List-Id: <linux-sh.vger.kernel.org>
References: <20130605070616.13311.69049.sendpatchset@w520>
 <20130605070625.13311.17016.sendpatchset@w520>
In-Reply-To: <20130605070625.13311.17016.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wednesday 05 June 2013 16:06:25 Magnus Damm wrote:
> 
> +__ZRELADDR     := $(shell /bin/bash -c \
> +                    'echo $(loadaddr-y) | tr " " "\n" | sort | uniq')
> +

It's not important, but I think this can be written much simpler using
makefile syntax as

__ZRELADDR	:= $(sort $(loadaddr-y))

	Arnd
