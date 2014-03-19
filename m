From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 19 Mar 2014 20:24:17 +0000
Subject: Re: [PATCH 59/62] ARM: shmobile: ak4642 needs i2c support
Message-Id: <201403192124.17492.arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <1395257399-359545-60-git-send-email-arnd@arndb.de>
 <532A0323.3080305@cogentembedded.com>
In-Reply-To: <532A0323.3080305@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wednesday 19 March 2014, Sergei Shtylyov wrote:
> On 03/19/2014 10:29 PM, Arnd Bergmann wrote:
> 
> > We cannot select SND_SOC_AK4642 if the I2C core layer
> > is disabled. Making the select statement conditional
> > ensures that we can build all configurations.
> 
>     Yes, but you also touch WM8978 selects. Is it the same as AK4642 or you 
> just forgot to mention that?

My bad, I probably screwed up when I folded some older patches
into a common one.

	Arnd
