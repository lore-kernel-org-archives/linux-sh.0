From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 24 May 2013 14:10:34 +0000
Subject: Re: [PATCH 06/17 v2] ARM: shmobile: r8a7778: add I2C support
Message-Id: <519F74DA.8010607@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <874ndu4c4n.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <874ndu4c4n.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 24-05-2013 8:39, Kuninori Morimoto wrote:

>>> +void __init r8a7778_add_i2c_device(int id)
>>> +{
>>> +	BUG_ON(id < 0 || id > 3);
>>> +
>>> +	platform_device_register_simple(
>>> +		"i2c-rcar", id,
>>> +		i2c_resources + (2 * id), 2);

>>       I've already told you () is superfluous.

> I can prevent misreading.

    I don't think anybody familiar with arithmetic operator priorities 
(i.e. having graduated from a primary school) can misread this.

> Best regards
> ---
> Kuninori Morimoto

WBR, Sergei

