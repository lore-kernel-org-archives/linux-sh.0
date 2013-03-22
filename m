From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 22 Mar 2013 20:35:07 +0000
Subject: Re: [PATCH v2] ARM: shmobile: streamline mackerel SD and MMC devices
Message-Id: <10827784.JsXBH1jb3F@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1303221056550.12375@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1303221056550.12375@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Guennadi,

Thanks for the patch.

On Friday 22 March 2013 11:01:53 Guennadi Liakhovetski wrote:
> This patch fixes the following issues with SD and MMC interfaces on
> mackerel: 1. replace custom card-detection functions with standard GPIO CD
> API 2. resources don't have to be numbered
> 3. add SDHI interrupt names
> 4. remove OCR masks, where regulators are used
> 5. don't specify SDHI CD interrupts. The pin is only present on SDHI0, and
>    even there we use it in GPIO mode to save power when no card is in the
>    slot
> 6. don't instantiate an MMCIF device and initialise MMCIF pins if SDHI1 is
>    selected
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

-- 
Regards,

Laurent Pinchart

