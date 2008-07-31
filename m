From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 31 Jul 2008 14:43:51 +0000
Subject: Re: i2c old to new style conversion
Message-Id: <20080731144351.GA23338@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4891CB91.6040308@spesonline.com>
In-Reply-To: <4891CB91.6040308@spesonline.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jul 31, 2008 at 04:27:56PM +0200, Luca Santini wrote:
> (diff attached)
> 
> 
> Hi Manuel,
> i'm trying the conversion of wm8731 driver and a attach my patch.
> 
> The problem is: the method wm8731_i2c_probe() - connected to
> i2c_add_driver.probe field - isn't called and alsa says "No Soundcard
> found".
> 
> 
> in the old style driver the method wm8731_codec_probe()  - connected to
> i2c_add_driver.attach_adapter field -  is called during initialization
> by i2c_add_driver() .
> 
> How to call wm8731_i2c_probe()? Do i miss something?
> 
> 

You should be sending this inquiry to the i2c list, where someone might
be able to help you with i2c related problems.
