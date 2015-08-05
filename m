From: Daniel Lezcano <daniel.lezcano@linaro.org>
Date: Wed, 05 Aug 2015 12:38:16 +0000
Subject: Re: Traceback in -next due to commit 'clockevents/drivers/sh_tmu: Migrate to new 'set-state' interfa
Message-Id: <55C203B8.4080206@linaro.org>
List-Id: <linux-sh.vger.kernel.org>
References: <55AD6314.2050000@roeck-us.net> <20150721023114.GD4994@linux> <55ADB37C.5020306@roeck-us.net> <CAMuHMdXpxcu_Rmi6p6JvAwB8Tr19Fr7oEBVbWXN1G0QyYPVr2g@mail.gmail.com> <20150803155155.GF21529@linux>
In-Reply-To: <20150803155155.GF21529@linux>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Viresh Kumar <viresh.kumar@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>

On 08/03/2015 05:51 PM, Viresh Kumar wrote:
> On 03-08-15, 17:03, Geert Uytterhoeven wrote:
>> I'm seeing the same WARNING on ARM (r8a7740/armadillo), and it's fixed by
>> your patch.
>>
>> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Thanks. Daniel is back now and we should see this in linux-next soon.

Fixed and pushed in clockevents/next

--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

