From: Cao Minh Hiep <cm-hiep@jinso.co.jp>
Date: Fri, 29 May 2015 01:11:39 +0000
Subject: Re: [Bug Report] DU: Error messages at boot log and can't show image on RGB Display.
Message-Id: <5567BCCB.3070909@jinso.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <5552F298.2020201@jinso.co.jp>
In-Reply-To: <5552F298.2020201@jinso.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent-san
Thanks for your feedback

>>>> We'd like to report this problem first.
>>>> There are no error message at version v4.0 stable.
>>>> And showed the image on RGB Display normally at version v4.0 stable.
>>>> We are looking for the error patch that added between v4.0 and v4.1-rc2.
>>> I've tried v4.1-rc2 and haven't experienced that problem. It might be
>>> related to kernel configuration, could you please share your .config file
>>> ?
>> We found that, if revert these patches then rebuild kernel, the error
>> logs "encoder initialization failed..." will be disappeared:
>> 26c00ab ARM: shmobile: lager: Add DU external pixel clocks to DT
>> fd25cdd ARM: shmobile: lager: Add DU HDMI output support
>> These patch added between v4.0 and v4.1-rc2.
>> But with this test, a bmp image still could not show on RGB Display.
> The error message isn't fatal. It's caused by HDMI support being disabled for
> the rcar-du driver, so the driver warns that the HDMI encoder can't be
> initialized.
>
> I'll submit a patch that adds the encoder name to the error message to ease
> debugging, but the message itself is normal. The driver should initialize all
> the other encoders properly.
>
> I've retested this on a stock v4.1-rc2 kernel with the kernel configuration
> file you've provided. I can reproduce the error message, and then noticed a
> potential kernel crash caused by a bug in the rcar-du driver. I have submitted
> a patch to fix it (and have CC'ed you).
>
> With the fix applied I can use the DU normally with the modetest application.
> I've also tested the fbdev compat layer, and can confirm that you won't get an
> output on the screen if you don't configure the display first. This can be
> done through the KMS API or the FBDEV API (FBIOPUT_VSCREENINFO).
>
Thanks for you patches and support.
I have tried to add your patches to v4.1-rc2 or rc5 for testing,
but I couldn't add the patch of [PATCH 1/3]:

"[PATCH 1/3] drm: rcar-du: Fix crash with groups that have less than 9 planes"

Could you please tell me which version can I add these patches?

Best regards,
Hiep.

