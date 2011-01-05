From: Chris Ball <cjb@laptop.org>
Date: Wed, 05 Jan 2011 21:06:32 +0000
Subject: Re: [PATCH 2/3 v3] mmc: tmio: implement a bounce buffer for
Message-Id: <20110105210632.GI9198@void.printf.net>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1011231711240.25676@axis700.grange> <Pine.LNX.4.64.1011231723090.25676@axis700.grange> <20110105195655.GD9198@void.printf.net> <Pine.LNX.4.64.1101052152180.5375@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1101052152180.5375@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>, Samuel Ortiz <sameo@linux.intel.com>

Hi Guennadi,

On Wed, Jan 05, 2011 at 09:56:01PM +0100, Guennadi Liakhovetski wrote:
> For example, with SDIO WLAN cards, some transfers happen with buffers at
> odd addresses, whereas the SH-Mobile DMA engine requires even addresses
> for SDHI. This patch extends the tmio driver with a bounce buffer, that
> is used for single entry scatter-gather lists both for sending and
> receiving. If we ever encounter unaligned transfers with multi-element
> sg lists, this patch will have to be extended. For now it just falls
> back to PIO in this and other unsupported cases.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> 
> Chris, thanks for your comments, but you picked up a wrong version of this 
> patch. Please, use links from my "outstanding patches" email.

Thanks.  Actually, I got the right patch but then replied to the wrong
e-mail.  :)  Pushed v3 to mmc-next now. 

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
