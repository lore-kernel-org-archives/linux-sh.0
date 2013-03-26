From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 26 Mar 2013 15:53:14 +0000
Subject: Re: [PATCH 03/13 v2] sh-pfc: r8a73a4: GPIO IRQ support
Message-Id: <1513270.Tso6xcSMfz@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <20130326135009.31366.75776.sendpatchset@w520>
In-Reply-To: <20130326135009.31366.75776.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

Thanks for the patch.

On Tuesday 26 March 2013 22:50:09 Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> V2 of code to add GPIO -> IRQ mappings to the
> PFC table for the r8a73a4 SoC. Requires the IRQs
> to be mapped at a fixed location in Linux IRQ
> space. The actual IRQs are not handled by the
> PFC, instead IRQC is used on r8a73a4.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Laurent Pinchart <laurent.pinchart@ideasonboard.com>

-- 
Regards,

Laurent Pinchart

