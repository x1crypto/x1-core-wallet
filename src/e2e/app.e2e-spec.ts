import { AngularElectronPage } from './app.po';
import { browser, element, by } from 'protractor';

describe('stratis-core App', () => {
  let page: AngularElectronPage;

  beforeEach(() => {
    page = new AngularElectronPage();
  });

  it('Page title should be X1 Core Wallet', () => {
    page.navigateTo('/');
    expect(page.getTitle()).toEqual('X1 Core Wallet');
  });
});
