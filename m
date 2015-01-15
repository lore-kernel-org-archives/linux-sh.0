From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 15 Jan 2015 17:03:49 +0000
Subject: Re: [PATCH 1/2] sh-pfc: r8a7791: fix typo in MLB_CLK
Message-Id: <54B7F2F5.6060207@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1479250.GJuNxlSkHs@wasted.cogentembedded.com> <CACRpkdYo0Jf5yXrwHsPL+L-6VH7OkpYMi6UtsmrHEG1qmzCCsA@mail.gmail.com>
In-Reply-To: <CACRpkdYo0Jf5yXrwHsPL+L-6VH7OkpYMi6UtsmrHEG1qmzCCsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

Hello.

On 01/15/2015 07:10 PM, Linus Walleij wrote:

>> The R8A7791 manual sometimes calls the signal MLB_CLK and sometimes MLB_CK; the
>> latter can only be encountered in the PFC section and  is probably  just a typo
>> (this  signal is always called MLB_CLK in the R8A7790  manual). Fix occurences
>> of MLB_CK throughout the R8A7791 PFC driver.

>> Based on original patch by Andrey Gusakov <andrey.gusakov@cogentembedded.com>.

>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

> Patch applied with the ACKs.

    Thanks. But to which tree/branch? I'm not seeing it anywhere...

> Yours,
> Linus Walleij

WBR, Sergei

