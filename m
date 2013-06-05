From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 05 Jun 2013 07:31:27 +0000
Subject: Re: [PATCH 00/06] ARM: shmobile: Per-board memory size fixups
Message-Id: <CANqRtoSwAxyDDB2WZLKNTQQrgSz9YVWsd0bcy7OqwLYWeWhhnQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20130605073410.15758.37563.sendpatchset@w520>
In-Reply-To: <20130605073410.15758.37563.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Jun 5, 2013 at 4:34 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> ARM: shmobile: Per-board memory size fixups
>
> [PATCH 01/06] ARM: shmobile: Introduce SHMOBILE_FIXUP() helper
> [PATCH 02/06] ARM: shmobile: AG5EVM memory config via ATAGS fixup
> [PATCH 03/06] ARM: shmobile: AP4EVB memory config via ATAGS fixup
> [PATCH 04/06] ARM: shmobile: Bonito memory config via ATAGS fixup
> [PATCH 05/06] ARM: shmobile: Kota2 memory config via ATAGS fixup
> [PATCH 06/06] ARM: shmobile: Marzen memory config via ATAGS fixup

Oh, ok, the above turned out to be an old version of the patch names.
Before I cause more confusion, the patch names are supposed to be like this:

[PATCH 01/06] ARM: shmobile: Introduce SHMOBILE_FIXUP() helper
[PATCH 02/06] ARM: shmobile: AG5EVM memory size fixup
[PATCH 03/06] ARM: shmobile: AP4EVB memory size fixup
[PATCH 04/06] ARM: shmobile: Bonito memory size fixup
[PATCH 05/06] ARM: shmobile: Kota2 memory size fixup
[PATCH 06/06] ARM: shmobile: Marzen memory size fixup

Thanks,

/ magnus
