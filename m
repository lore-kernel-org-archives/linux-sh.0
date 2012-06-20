From: Chris Ball <cjb@laptop.org>
Date: Wed, 20 Jun 2012 06:21:03 +0000
Subject: Re: [PATCH] mmc: sh_mmcif: Support MMC_SLEEP_AWAKE command
Message-Id: <87k3z24i7k.fsf@octavius.laptop.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1339534569-27923-1-git-send-email-laurent.pinchart@ideasonboard.com>
	<Pine.LNX.4.64.1206131527410.17854@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1206131527410.17854@axis700.grange> (Guennadi
	Liakhovetski's message of "Wed, 13 Jun 2012 15:27:54 +0200 (CEST)")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-mmc@vger.kernel.org, Simon Horman <horms@verge.net.au>, linux-sh@vger.kernel.org

Hi,

On Wed, Jun 13 2012, Guennadi Liakhovetski wrote:
> On Tue, 12 Jun 2012, Laurent Pinchart wrote:
>
>> The MMC_SLEEP_AWAKE and SD_IO_SEND_OP_COND commands share the same
>> opcode. SD_IO_SEND_OP_COND isn't supported by the SH MMCIF, but
>> MMC_SLEEP_AWAKE is. Discriminate between the two commands using the
>> command flags, and reject SD_IO_SEND_OP_COND only.
>> 
>> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
> Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Thanks, pushed to mmc-next for 3.6.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
