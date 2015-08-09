From: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Date: Sun, 09 Aug 2015 12:29:14 +0000
Subject: Re: [PATCH 10/10] i2c: dt: describe generic bindings
Message-Id: <55C744CA.7080108@linaro.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1439066007-13951-1-git-send-email-wsa@the-dreams.de> <1439066007-13951-11-git-send-email-wsa@the-dreams.de> <55C722A5.4020403@linaro.org> <20150809121545.GA1521@katana>
In-Reply-To: <20150809121545.GA1521@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Andrey Danin <danindrey@mail.ru>, Stephen Warren <swarren@wwwdotorg.org>



On Sunday 09 August 2015 05:45 PM, Wolfram Sang wrote:
>
>> Thanks for the patch and it looks good to me.
>
> Thanks, I interpret this as an Acked-by :)
>
>> Shouldn't we also update/add other generic optional properties?
>> For example,
>>
>>   - i2c-sclk-low-time-ns
>>   - i2c-sclk-high-time-ns
>>   - etc...
>
> Yes, I will do this as an incremental patch once people are happy with
> this start. Review is usually easier if done in small chunks.
>

Agreed.

Feel free to add

Reviewed-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>

Thanks,
Vaibhav
