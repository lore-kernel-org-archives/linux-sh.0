From: Chen Gang S <gang.chen@sunrus.com.cn>
Date: Sun, 22 Feb 2015 09:13:56 +0000
Subject: Re: [PATCH] drm: Kconfig: Let all DRM_GEM_CMA_HELPER related macros depend on HAVE_DMA_ATTRS
Message-Id: <54E99DD4.6010602@sunrus.com.cn>
List-Id: <linux-sh.vger.kernel.org>
References: <54CE3361.9090107@sunrus.com.cn> <54CFEBA2.9070801@sunrus.com.cn>
In-Reply-To: <54CFEBA2.9070801@sunrus.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: airlied@linux.ie, p.zabel@pengutronix.de, laurent.pinchart@ideasonboard.com
Cc: robdclark@gmail.com, boris.brezillon@free-electrons.com, nicolas.ferre@atmel.com, benjamin.gaignard@linaro.org, jg1.han@samsung.com, dri-devel@lists.freedesktop.org, linux-sh@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, chris@zankel.net, jcmvbkbc@gmail.com

On 2/3/15 05:26, Chen Gang S wrote:

[...]
 
> 
>  - Xtensa gcc5 cross compiler has issues:
> 
>    it causes more than 10 broken areas with allmodconfig (but no issues
>    with defconfig). I guess, in fact, it is only 1 real issue (which can
>    cause all breaks), and I shall try to fix it within this month.
>

I finish analysing for it, it is really only one issue for gcc5, and I
guess, this issue is also not only for xtensa. I send related fix patch
to gcc patch mailing list, hope it can pass checking.

The cause is "the variables are not initialized before using them", the
bug information is "https://gcc.gnu.org/bugzilla/show_bug.cgi?ide117".

After fix this issue, it can build xtensa Linux kernel with allmodconfig
successfully.

[...]

Thanks.
-- 
Chen Gang

Open, share, and attitude like air, water, and life which God blessed
