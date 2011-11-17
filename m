From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 17 Nov 2011 18:54:46 +0000
Subject: Re: [PATCH 0/3 v2] Switch sh7722, sh7723, and sh7724 to a generic sh-mobile runtime PM
Message-Id: <20111117185445.GB30555@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1111171446150.2650@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1111171446150.2650@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Nov 17, 2011 at 02:55:42PM +0100, Guennadi Liakhovetski wrote:
> The sh/pm-runtime branch of https://github.com/pmundt/linux-sh begins the 
> migration of SuperH platforms from their hwblk runtime PM implementation 
> to the common with ARM-based sh-mobile platforms code. These patches 
> actually migrate sh7722, sh7723, and sh7724 architectures over.
> 
> v2 is functionally identical to v1, it only removes the MSTP() wrapper, as 
> requested by Paul.
> 
Looks better, thanks. I'll queue them up in sh/pm-runtime.
