From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 08 Aug 2014 12:58:14 +0000
Subject: Re: [PATCH] sh-pfc: r8a7791: fix CAN pin groups
Message-Id: <CACRpkdau7ZRQtGTV3nDCDmesv8Htp=+eqawu2G9q5EQLYrJONw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201407290212.55656.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201407290212.55656.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jul 29, 2014 at 12:12 AM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:

> I had made last-minute changes before submitting the patch "sh-pfc: r8a7791:
> add CAN pin groups"; now I'm seeing that they weren't complete: I had missed
> update to the pin group names in pin[01]_groups[]. Drop the "_a" suffixes there.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>
> ---
> The patch is against the 'devel' branch of Linus W.'s 'linux-pinctrl.git' repo.

Patch applied for fixes with Laurent's ACK.

Yours,
Linus Walleij
