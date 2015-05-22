From: Cao Minh Hiep <cm-hiep@jinso.co.jp>
Date: Fri, 22 May 2015 00:13:04 +0000
Subject: Re: [Bug Report] Rcar-H2: VIN: Error messages at boot log
Message-Id: <555E7490.2090302@jinso.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <CAMuHMdVKDou8kOcVvLqJO2C14zYP-hhASWS_4kSShqLdqVq7Jg@mail.gmail.com>
In-Reply-To: <CAMuHMdVKDou8kOcVvLqJO2C14zYP-hhASWS_4kSShqLdqVq7Jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org

Hi Geert-san
Thank for your feedback!

On 2015年05月21日 16:17, Geert Uytterhoeven wrote:
> Hi Hiep-san,
>
> On Thu, May 21, 2015 at 3:56 AM, Cao Minh Hiep <cm-hiep@jinso.co.jp> wrote:
>> We have tested Linux upstream version-4.1-rc2 on Lager and Koelsch.
>> We found a Error message of VIN(Video Input) at boot logs:
>> The error messages is showed as below:
>> "adv7180 6-0020: chip found @ 0x20 (e6520000.i2c)
>> soc-camera-pdrv soc-camera-pdrv.0: Probing soc-camera-pdrv.0
>> rcar_vin e6ef1000.video: group probe failed: -6"
>>
>> We tested it by default config, and Linaro userland v2014.09.
>> Is it a bug?
> I see the same error message in a shmobile_defconfig kernel built from
> renesas-drivers-2015-04-27-v4.1-rc1.
>
> I've just tried a shmobile_defconfig kernel built in a tree based on
> renesas-drivers-2015-05-19-v4.1-rc4, and the error message is gone.
>
> I don't know what fixed it.
I re-tested renesas-drivers-2015-05-19-v4.1-rc4 on my Lager board.
My result test is the same, the error message is gone.

I also checked on upstream v4.1-rc4, but the error massage still has.
I think, there is a patch that fixed it between two versions.

Best Regards,
Hiep.
