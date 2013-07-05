From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 05 Jul 2013 01:27:44 +0000
Subject: Re: [PATCH 2/6] ARM: shmobile: APE6EVM: add MMCIF support
Message-Id: <CANqRtoQCr160N8eQxMV6WhUr=7RGkdeY=hDtU6n7Ut0GK__iKg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1372970334-21485-3-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1372970334-21485-3-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Guennadi,

Thanks for your efforts on this.

On Fri, Jul 5, 2013 at 5:38 AM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> Add MMCIF support to the APE6EVM board in both PIO and DMA modes, depending
> on the DMAC driver availability.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

This also goes without saying, but please add comments in the code and
in the commit log explaining how the current implementation assumes
the voltage to be static, but while the actual hardware allows the
PMIC to control the voltage.

Also, in the near future please finalize your earlier work where you
add MMCIF support to the DT reference board support - a separate
commit is fine with me, but make sure it gets merged.

Apart from that,

Acked-by: Magnus Damm <damm@opensource.se>
