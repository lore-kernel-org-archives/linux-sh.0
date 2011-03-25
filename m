From: Chris Ball <cjb@laptop.org>
Date: Fri, 25 Mar 2011 13:09:14 +0000
Subject: Re: outstanding tmio patches
Message-Id: <m37hbnmjnp.fsf@pullcord.laptop.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1103231505450.6836@axis700.grange>
	<m3k4folztx.fsf@pullcord.laptop.org>
	<Pine.LNX.4.64.1103250858400.22824@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1103250858400.22824@axis700.grange> (Guennadi
	Liakhovetski's message of "Fri, 25 Mar 2011 09:04:02 +0100 (CET)")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>, Magnus Damm <magnus.damm@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Paul Mundt <lethal@linux-sh.org>, Linus Walleij <linus.walleij@linaro.org>

Hi,

On Fri, Mar 25 2011, Guennadi Liakhovetski wrote:
>> > [1/2] mmc: tmio: Improve DMA stability on sh-mobile
>> 
>> Some serious merge conflicts with Linus W's dmaengine cleanup here.
>
> Sorry, I must be missing something. I'm basing my patches on the current 
> (of yesterday) next tree, which already contains Linus' patches:

I agree that linux-next contains these patches, but I don't agree that
"mmc: tmio: Improve DMA stability on sh-mobile" (which was written back
on March 7th before they were merged) avoids merge conflicts with them.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
