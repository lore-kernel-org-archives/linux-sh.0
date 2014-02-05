From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 05 Feb 2014 12:16:32 +0000
Subject: Re: [PATCH 10/11] PCI: rcar: add error interrupt handling
Message-Id: <CANqRtoT76UgoRGLfitRXOi7bw3tKe2YgS50UU57TvUdb18zBjw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1391595554-20640-11-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1391595554-20640-11-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Feb 5, 2014 at 7:19 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> Add option to enable interrupts to report any errors from
> the AHB-PCI bridge to help find any issues with the bridge
> when in use.
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
> v2:
>         - removed kconfig entry and use CONFIG_PCI_DEBUG
>         - check for irq > 0 before trying to attach irq
>

v2 looks good to me, thanks!

/ magnus
