From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Thu, 12 Apr 2012 01:54:29 +0000
Subject: Re: [PATCH v2] usb: ehci-sh: Add PHY init function with platform data
Message-Id: <4F8635D5.2060403@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1332312420-31674-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
In-Reply-To: <1332312420-31674-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org

Paul Mundt さんは書きました:
> On Fri, Mar 23, 2012 at 01:38:38PM +0900, Nobuhiro Iwamatsu wrote:
>> Paul Mundt ????????????????????????:
>>> On Wed, Mar 21, 2012 at 03:47:00PM +0900, Nobuhiro Iwamatsu wrote:
>>>> In devices using ehci-sh, initialization of the PHY may be necessary.
>>>> This adds platform data to ehci-sh and provide function to initialize PHY.
>>>>
>>>> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
>>>> CC: Shimoda Yoshihiro <yoshihiro.shimoda.uh@renesas.com>
>>> It's impossible to say whether this makes sense or not without first
>>> seeing what you are trying to do in the callback.
>>>
>> For example, it is necessary to initialize it after having
>> ebabled clock of ehci in sh7734.
>> I perform initialization CPU specific in callback.
>> For example, following.
>>
> Ok, that seems fine. I'd prefer to see the header in
> include/linux/platform_data/, however. Also, when can we expect an
> upstream user for this? I don't mind adding support for it, but it
> doesn't make much sense to have upstream if there aren't any in-tree
> users.
> 

OK, I will move to include/linux/platform_data/.
And Renesas sh7734 uses this now only.
Moreover, it can use for initialization of PHY by other SH CPUs.

Nobuhiro
