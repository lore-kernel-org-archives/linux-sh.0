From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 09 Mar 2015 07:06:59 +0000
Subject: Re: Can't boot kernel v4.0-rc2 on Koelsch
Message-Id: <2263226.JPOqZgiCRj@avalon>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello Hiep-san,

On Monday 09 March 2015 10:07:04 Cao Minh Hiep wrote:
> Hi Laurent-san
> 
> I am Hiep from Jinzai Solution.
> I'm sorry to bother you again!

No worries.

> We are testing the linux ver v4.0-rc2 on Koelsch, We can not boot the
> kernel v4.0-rc2 on Koelsch,
> Then we found a patch has changed as below:
> "1f75cda ARM: shmobile: koelsch: Rename SCIF[01] serial ports to ttySC[01]"
> 
> Please see it when you have time!

Could you please detail your boot failure ? You might need to change your 
/etc/inittab to adjust to the serial port new name, but apart from that there 
shouldn't be any issue. I can boot my Koelsch board on 4.0-v2.

-- 
Regards,

Laurent Pinchart

