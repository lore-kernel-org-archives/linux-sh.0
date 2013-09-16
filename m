From: Ulrich Hecht <ulrich.hecht@gmail.com>
Date: Mon, 16 Sep 2013 13:23:46 +0000
Subject: Re: [PATCH 0/3] Lager i2c bus support
Message-Id: <CAO3366x0Xgbhcg_gASkeNa7F_R-K0y60W-Vk3KRaAHm2NOx8+A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1378813194-19493-1-git-send-email-ulrich.hecht@gmail.com>
In-Reply-To: <1378813194-19493-1-git-send-email-ulrich.hecht@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Sep 12, 2013 at 3:51 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> What is your preferred way to resolve this? We can choose one of the
> following:
>
> 1. merge the two i2c clock patches into one - feel free to take my code
> into "ARM: shmobile: r8a7790: add the I2C bus clock" from this series
>
> 2. port one of the patches on top of the other one - if this series isn't
> going to be modified again, I can port my patch on top of it.

Since my DU stuff will have to be ported to DT anyway and I have found
that my work towards that on the rcar-i2c driver is virtually
identical to what Guennadi has already posted, I'd suggest to go with
his version.

CU
Uli
