From: Chris Ball <cjb@laptop.org>
Date: Fri, 25 Mar 2011 14:01:44 +0000
Subject: Re: outstanding tmio patches
Message-Id: <m3mxkjl2nr.fsf@pullcord.laptop.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1103231505450.6836@axis700.grange>
	<m3k4folztx.fsf@pullcord.laptop.org>
In-Reply-To: <m3k4folztx.fsf@pullcord.laptop.org> (Chris Ball's message of
	"Thu, 24 Mar 2011 22:05:14 -0400")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>, Magnus Damm <magnus.damm@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Paul Mundt <lethal@linux-sh.org>

Hi Guennadi,

On Thu, Mar 24 2011, Chris Ball wrote:
>> [1/2] mmc: tmio: Improve DMA stability on sh-mobile
>> [2/2] mmc: tmio: use PIO for short transfers

Thanks, these two are applied now.

>> [1/6,v2] mmc: tmio: split core functionality, DMA and MFD glue

But now we have a merge conflict here, since we just changed the
codebase that this patch moves around.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
