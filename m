From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 11 Dec 2013 09:36:50 +0000
Subject: Re: [PATCH] ARM: rcar-gen2: Do not attempt to re-setup timer if running correctly
Message-Id: <CANqRtoSEu4-XoPZZ5Ugf8=yARCX=MGZsdx1QcKkgAwe2BH60bw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1386753916-25648-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1386753916-25648-1-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Dec 11, 2013 at 6:25 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> If the system has been started in non-secure mode, then the ARM generic
> timer is not configurable during the kernel initialisation. Currently
> the only thing we can check for is if the timer has been correctly
> configured during the boot process.
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> Reviewed-by: Ian Molton <ian.molton@codethink.co.uk>

Looks fine, thanks!

Acked-by: Magnus Damm <damm@opensource.se>
