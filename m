From: Magnus Damm <magnus.damm@gmail.com>
Date: Sat, 23 Mar 2013 22:29:03 +0000
Subject: Re: [PATCH v2] ARM: shmobile: streamline mackerel SD and MMC devices
Message-Id: <CANqRtoSNUNsXyqkgFLoeQA1jVn0Xvg2KWmywAMRS4-_m26BxWw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1303221056550.12375@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1303221056550.12375@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Guennadi,

On Fri, Mar 22, 2013 at 7:01 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> This patch fixes the following issues with SD and MMC interfaces on mackerel:
> 1. replace custom card-detection functions with standard GPIO CD API
> 2. resources don't have to be numbered
> 3. add SDHI interrupt names
> 4. remove OCR masks, where regulators are used
> 5. don't specify SDHI CD interrupts. The pin is only present on SDHI0, and
>    even there we use it in GPIO mode to save power when no card is in the
>    slot
> 6. don't instantiate an MMCIF device and initialise MMCIF pins if SDHI1 is
>    selected
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> ---
>
> v2: updated to the current shmobile tree: remove redundant gpio_request()
> calls, replaced GPIO_PORTx macros with plain GPIO numbers. Also
> additionally remove SDHI0 native card detection interrupt

Thanks for your patch. May I ask why you decide to implement one
single patch with multiple functional changes in it? For instance,
keeping the SDHI bits separate would make it easier to track down any
potential SDHI regressions that may be introduced by accident - this
without dealing with MMCIF.

I'd rather see you splitting out this kind of patch into multiple
individual per-hardware and per-function patches.

Thanks,

/ magnus
