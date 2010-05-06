From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 06 May 2010 04:41:47 +0000
Subject: Re: [PATCH 1/9 v2] sh: define DMA slaves per CPU type, remove now
Message-Id: <AANLkTim4bALDN9ojsPXBhbMHMSSYDY-Z1PeXfADGNzP7@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1005041318200.4925@axis700.grange>
	 <Pine.LNX.4.64.1005041336080.4925@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1005041336080.4925@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, linux-mmc@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Ian Molton <ian@mnementh.co.uk>

On Tue, May 4, 2010 at 11:06 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> Now that DMA slave IDs are only used used in platform specific code and have
> become opaque cookies for the rest of the code, we can make the, CPU specific
> too.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
>
> This patch is new in v2 - added per request from Magnus.

Thank you Guennadi, this looks very good!

/ magnus
