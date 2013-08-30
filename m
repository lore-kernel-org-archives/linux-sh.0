From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 30 Aug 2013 07:48:38 +0000
Subject: Re: [PATCH] emev2: GPIOLIB: Enable support for OF
Message-Id: <CACRpkdbeCU_WG4xXvoh76RZ-9UtbWJvB4PqYhSpTXSF4Hodf2A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1377623069-32678-1-git-send-email-ian.molton@codethink.co.uk>
	<1377623069-32678-2-git-send-email-ian.molton@codethink.co.uk>
	<CACRpkdZB+Dm1jhWRu+rdT0V7Q0iwozsd2gQ6M+=55h2SJHQHWw@mail.gmail.com>
	<20130830034746.GB17800@verge.net.au>
In-Reply-To: <20130830034746.GB17800@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>
Cc: Ian Molton <ian.molton@codethink.co.uk>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

On Fri, Aug 30, 2013 at 5:47 AM, Simon Horman <horms@verge.net.au> wrote:
> On Thu, Aug 29, 2013 at 07:41:42PM +0200, Linus Walleij wrote:

>> Either the statement needs to be inside #ifdef CONFIG_OF_GPIO
>> or the Emma driver need to select OF_GPIO in its Kconfig
>> entry.
>
> This may be somewhat naieve, but it seems to me that the latter would be a
> better choice at this stage because AFIK the only in-tree emev2 board is
> the kzm9d and it uses USE_OF.

I think you're right. Ian can you cook a patch that also selects
OF_GPIO for this controller in Kconfig?

Yours,
Linus Walleij
