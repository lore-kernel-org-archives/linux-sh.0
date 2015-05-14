From: Cao Minh Hiep <cm-hiep@jinso.co.jp>
Date: Thu, 14 May 2015 03:18:21 +0000
Subject: Re: [Bug Report] DU: Error messages at boot log and can't show image on RGB Display.
Message-Id: <555413FD.6050308@jinso.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <5552F298.2020201@jinso.co.jp>
In-Reply-To: <5552F298.2020201@jinso.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org

Hi Laurent-san,

I'd like to report some more informations

On 2015年05月14日 06:56, Laurent Pinchart wrote:
> Hello,
>
> On Wednesday 13 May 2015 15:43:36 Cao Minh Hiep wrote:
>> Hi All.
>>
>> We are testing Linux upstream version-4.1-rc2 on Lager.
>> We found a Error message of DU(Display Unit) at boot logs:
>> The Warning messages is showed as below:
>> "rcar-du feb00000.display: encoder initialization failed, skipping"
>> Then we tried to show a .bmp image on RGB Display via RGB port. But it
>> didn't work.
>>
>> Testing method:
>> 1. Connect RGB Display to RGB port on Lager.
>> 2. Show a BMP image on Display by this command:
>> # bmap /dev/fb0 ./image.bmp
>>
>> We'd like to report this problem first.
>> There are no error message at version v4.0 stable.
>> And showed the image on RGB Display normally at version v4.0 stable.
>> We are looking for the error patch that added between v4.0 and v4.1-rc2.
> I've tried v4.1-rc2 and haven't experienced that problem. It might be related
> to kernel configuration, could you please share your .config file ?
>

We found that, if revert these patches then rebuild kernel, the error 
logs "encoder initialization failed..." will be disappeared:
26c00ab ARM: shmobile: lager: Add DU external pixel clocks to DT
fd25cdd ARM: shmobile: lager: Add DU HDMI output support
These patch added between v4.0 and v4.1-rc2.
But with this test, a bmp image still could not show on RGB Display.


Thank you.
Jinso/Hiep.
