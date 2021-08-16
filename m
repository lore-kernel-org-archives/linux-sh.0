Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C446C4320A
	for <linux-sh@archiver.kernel.org>; Mon, 16 Aug 2021 06:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE8AF61A02
	for <linux-sh@archiver.kernel.org>; Mon, 16 Aug 2021 06:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbhHPGAt (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 16 Aug 2021 02:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbhHPGAt (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 16 Aug 2021 02:00:49 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AEFBC0613C1;
        Sun, 15 Aug 2021 23:00:10 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id r6so16329767ilt.13;
        Sun, 15 Aug 2021 23:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=R1jdHxIic6IG0RZ15JYwb6SfB1Sny3U++9rwdVIMbpc=;
        b=N538Qf00OU/4MWr9VhpTTwjjz9SYrRUmU+wweQpx/CiKvUYR0DsUPYVrZ0Gaksnecr
         g9S3DbjA10e6/LhX03Q/YEuVx7RHctOucgZpKaBB7OQroEHtp6WiVYtwY4j4uBOM7Dep
         aFZsxPg/cYmc5Ut7MvhXTrJM9q6FbUgp3exaV7LJJzmrc3OpHlKU5u3MRxiTyseN/6Ic
         mmgmuGTxF9gTnkL9m1yvSwe1+CXLnmKJJJ05ESWdilvokS4Sz4miG7SxykpEyUx7Of/4
         vUqe2wHvTZTk8YkBtUa/GSPjEYWKqmJjK+nBKwWI7v4pCVpX6LbT71N1X+gvY44bbg9c
         t8JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=R1jdHxIic6IG0RZ15JYwb6SfB1Sny3U++9rwdVIMbpc=;
        b=HCfioveJLEQSit8a2I4rn02e59M6iDTNUT8I5EXVprG6lr58EsmTfAM0fUriEUsaji
         CiFuInYoqo4Zmw+0OCii3av3GvV+UhlcuBnkVIfPrJYKXiqzcgPWLhPfmKuugkrJxfHp
         tEBe4zTnWxbPA8OHAAyIsF9eZS6YWcKvn9B1L0faGG0T4ghsfZyqpP7OUvcPc9jrOZAN
         uvcQTFl3Vn4VRzhVrgeQt7EVxs7Wl/UkARgk7R8SnyaCfRtYv8lWR2V4ZE03QNivQWE9
         aKrz/Sj7MxkbMyNdriccD5XXgkrFC5sFW1pdpvQSVVQCE4CULv4rHWtXuW3++pVOrVb2
         z6CQ==
X-Gm-Message-State: AOAM531vL9JFyVlulwCkQb/PPPqREJhf7eAXLEE9duTV470Ol9IUSmLS
        fo9HQkVzgKZLaALmrt+zMdrvN0ExqeP0H6WvoWk=
X-Google-Smtp-Source: ABdhPJxuEkukUOLBjIDa/Icne46+DbUoaLu1NrME7byItKN9OCgmA6jjCgnGn4HltxvhYkzwKVtCj7g9cFdJ35NR5EQ=
X-Received: by 2002:a92:3607:: with SMTP id d7mr10713042ila.5.1629093604163;
 Sun, 15 Aug 2021 23:00:04 -0700 (PDT)
MIME-Version: 1.0
From:   zhao xc <xinchao.zhao.kernelz@gmail.com>
Date:   Sun, 15 Aug 2021 22:59:53 -0700
Message-ID: <CAP7CzPfRFSfUka1Wjo1+KNSdhYjR2n59g2yvEFGRyfYwNFNy1A@mail.gmail.com>
Subject: 
To:     ysato@users.sourceforge.jp
Cc:     dalias@libc.org, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000957ea705c9a6e97d"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

--000000000000957ea705c9a6e97d
Content-Type: text/plain; charset="UTF-8"



--000000000000957ea705c9a6e97d
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-CONFIG_IP_NF_TARGET_LOG-Configuration-does-not-exist.patch"
Content-Disposition: attachment; 
	filename="0001-CONFIG_IP_NF_TARGET_LOG-Configuration-does-not-exist.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kse89bun0>
X-Attachment-Id: f_kse89bun0

RnJvbSBmN2EyYWJkMWM0Y2U0ZjQ2ZDk1NWIxZmEwMDA2MzExMzM1MmRlMzliIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiB6aGFveGluY2hhbyA8eGluY2hhby56aGFvQHVjYXMuY29tLmNu
PgpEYXRlOiBTdW4sIDE1IEF1ZyAyMDIxIDIwOjM1OjE2IC0wNzAwClN1YmplY3Q6IFtQQVRDSF0g
Q09ORklHX0lQX05GX1RBUkdFVF9MT0cgQ29uZmlndXJhdGlvbiBkb2VzIG5vdCBleGlzdAoKU2ln
bmVkLW9mZi1ieTogemhhb3hpbmNoYW8gPHhpbmNoYW8uemhhb0B1Y2FzLmNvbS5jbj4KLS0tCiBh
cmNoL3NoL2NvbmZpZ3MvdGl0YW5fZGVmY29uZmlnIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC9zaC9jb25maWdz
L3RpdGFuX2RlZmNvbmZpZyBiL2FyY2gvc2gvY29uZmlncy90aXRhbl9kZWZjb25maWcKaW5kZXgg
YmE4ODdmMTM1MWJlLi5hOGI0YTlkMzkzYmUgMTAwNjQ0Ci0tLSBhL2FyY2gvc2gvY29uZmlncy90
aXRhbl9kZWZjb25maWcKKysrIGIvYXJjaC9zaC9jb25maWdzL3RpdGFuX2RlZmNvbmZpZwpAQCAt
ODMsNyArODMsNyBAQCBDT05GSUdfSVBfTkZfTUFUQ0hfRUNOPW0KIENPTkZJR19JUF9ORl9NQVRD
SF9UVEw9bQogQ09ORklHX0lQX05GX0ZJTFRFUj1tCiBDT05GSUdfSVBfTkZfVEFSR0VUX1JFSkVD
VD1tCi1DT05GSUdfSVBfTkZfVEFSR0VUX0xPRz1tCitDT05GSUdfTkVURklMVEVSX1hUX1RBUkdF
VF9MT0c9bQogQ09ORklHX0lQX05GX01BTkdMRT1tCiBDT05GSUdfSVBfTkZfVEFSR0VUX0VDTj1t
CiBDT05GSUdfSVBfTkZfVEFSR0VUX1RUTD1tCi0tIAoyLjE3LjEKCg==
--000000000000957ea705c9a6e97d--
