From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 22 Jun 2010 23:34:43 +0000
Subject: Re: [PATCH] initialise DMA engine before MMC
Message-Id: <AANLkTil-xnYsCoK94MT8l2rwjDhifTWlkfukcGZ57Viu@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1006071312060.12965@axis700.grange>
	<20100621044030.GC29997@linux-sh.org>
In-Reply-To: <20100621044030.GC29997@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-kernel@vger.kernel.org, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>, linux-mmc@vger.kernel.org

On Sun, Jun 20, 2010 at 9:40 PM, Paul Mundt <lethal@linux-sh.org> wrote:
> On Mon, Jun 07, 2010 at 01:16:36PM +0200, Guennadi Liakhovetski wrote:
>> To use DMA engine based DMA with MMC in a non-modular build, the DMA
>> engine has to initialise before MMC.
>>
>> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>
> Dan, any objections to this?

No, objections, you can add my acked-by.
