From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 27 Mar 2013 15:37:13 +0000
Subject: Re: [PATCH] gpio: em: Make use of devm functions
Message-Id: <CANqRtoShQMCS3Cx+r9i1k7fWp6=TgqCX8h3d10qozr4Mt_5wQA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20130327061114.3356.57465.sendpatchset@w520>
	<CACRpkdY=UXZrRwuWp1JTePG71C=pAPc26kWWRqPZv_qZHc-_bg@mail.gmail.com>
In-Reply-To: <CACRpkdY=UXZrRwuWp1JTePG71C=pAPc26kWWRqPZv_qZHc-_bg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-kernel@vger.kernel.org, grant.likely@secretlab.ca, horms@verge.net.au, linux-sh@vger.kernel.org

On Thu, Mar 28, 2013 at 12:01 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> On Wed, Mar 27, 2013 at 7:11 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
>
>> From: Magnus Damm <damm@opensource.se>
>>
>> Update the Emma Mobile GPIO driver to make use of devm
>> functions. This simplifies the error handling and makes
>> the code more compact.
>>
>> Signed-off-by: Magnus Damm <damm@opensource.se>
>
> I guess this is a resend. IIRC I just applied it some hours ago...

Yep, correct. Thanks for your help!

Now if I only could find time to marry the gpio-em.c driver with sh-pfc.c..

/ magnus
