From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Wed, 04 Sep 2013 08:45:05 +0000
Subject: Re: [PATCH 2/2] SPI: EMMA Mobile SPI master driver
Message-Id: <5226F311.6000707@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1378227303-18795-2-git-send-email-ian.molton@codethink.co.uk>
In-Reply-To: <1378227303-18795-2-git-send-email-ian.molton@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 03/09/13 17:55, Ian Molton wrote:
> This patch provides support for the EMMA mobile SPI master controller.
>
> At present, only PIO mode is supported, and unless GPIOs are used for
> chipselect, transfers are limited to 4 bytes maximum.
>
> RW transfers are not supported, and only 8 bit words are supported at present.

you forgot to sign your work.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
